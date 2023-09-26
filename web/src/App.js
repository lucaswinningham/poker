import { useEffect } from 'react';

import AppWebSocket, { subscribed } from 'appWebSocket';

import logo from './logo.svg';
import './App.css';

function App() {
  useEffect(() => {
    const appWebSocket = new AppWebSocket({
      channel: 'Table::Channel',
      connectionEvents: {
        [subscribed]: ({ appWebSocket }) => {
          const data = { action: 'join', number: Math.floor(Math.random() * 100) };

          appWebSocket.send({ command: 'message', data });
        }
      },
      actionEvents: {
        joined: ({ message }) => console.log('joined', { ...message })
      },
      middlewares: [
        ({ message, type }) => {
          if (type !== 'ping') console.log({ ...message, type })
        }
      ]
    });

    console.log({appWebSocket});

    return () => {
      appWebSocket.close();
    };
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
