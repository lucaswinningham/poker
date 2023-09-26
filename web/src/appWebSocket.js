const noop = () => {};
const SOCKET_URL = 'ws://localhost:3000/cable';
const composeLeft = (...fns) => x => fns.reduce((y, f) => f(y), x);

const pinged = 'ping';
const connected = 'welcome';
const subscribed = 'confirm_subscription';

export { pinged, connected, subscribed };

const defaultConnectionEvents = {
  [pinged]: noop,
  [connected]: ({ appWebSocket }) => {
    appWebSocket.send({ command: 'subscribe' });
  },
  [subscribed]: noop
};

export default class AppWebSocket {
  constructor({ channel, actionEvents = {}, connectionEvents = {}, middlewares = [] }) {
    this.channel = channel;
    this.actionEvents = actionEvents;
    this.connectionEvents = { ...defaultConnectionEvents, ...connectionEvents };
    this.middleware = composeLeft(...middlewares.map((middleware) => (obj) => {
      return middleware(obj) || obj;
    }));

    this._webSocket = new WebSocket(SOCKET_URL);

    this._handleMessaging();
  }

  send = ({ command, data }) => {
    const args = { command, identifier: this._identifier };

    if (data) {
      args.data = JSON.stringify(data);
    }

    this._webSocket.send(JSON.stringify(args));
  }

  get channel() {
    return this._channel;
  }

  set channel(channel) {
    this._channel = channel;
    this._identifier = JSON.stringify({ channel });
  }

  _handleMessaging = () => {
    const determineEventFunction = ({ message, type }) => {
      if (type && this.connectionEvents[type]) {
        return this.connectionEvents[type];
      }

      if (message && message.action && this.actionEvents[message.action]) {
        return this.actionEvents[message.action];
      }

      return noop;
    };

    this._webSocket.onmessage = ({ data }) => {
      const parsedData = JSON.parse(data);
      const { message, type } = this.middleware({ ...parsedData, appWebSocket: this });
      const eventFunction = determineEventFunction({ message, type });

      eventFunction({ message, appWebSocket: this });
    };
  }
}
