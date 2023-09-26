module AppCallbacks
  extend ActiveSupport::Concern

  included do
    include ActiveSupport::Callbacks
  end

  class_methods do
    def define_app_callbacks(*callback_names)
      callback_names.each do |callback_name|
        symbolized_callback_name = callback_name.to_sym
        define_callbacks symbolized_callback_name

        instance_eval do
          ActiveSupport::Callbacks::CALLBACK_FILTER_TYPES.each do |filter_type|
            define_method "#{filter_type}_#{callback_name}" do |*methods|
              methods.each do |method|
                set_callback symbolized_callback_name, filter_type, method
              end
            end
          end
        end
      end
    end
  end
end
