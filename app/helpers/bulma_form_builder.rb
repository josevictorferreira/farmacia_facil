class BulmaFormBuilder < ActionView::Helpers::FormBuilder
  %w(text_field email_field password_field).each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        super(method, insert_class("input", options))
      end
    RUBY_EVAL
  end

  def label(method, text = nil, options = {}, &block)
    super(method, text, insert_class('label', options), &block)
  end

  def check_box(method, options = {})
    super(method, insert_class('checkbox', options))
  end

  def submit(method, options = {})
    super(method, insert_class('button is-primary', options))
  end

  private

  def insert_class(class_name, options)
    output = options.dup
    output[:class] = ((output[:class] || '') + " #{class_name}").strip
    output
  end
end
