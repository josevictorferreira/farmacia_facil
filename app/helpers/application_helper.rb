module ApplicationHelper
  def human_boolean(boolean)
    boolean ? I18n.t('shared.yes') : I18n.t('shared.no')
  end
end
