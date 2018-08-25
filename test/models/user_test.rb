require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Jose Teste',
                     email: 'user@example', password: 'test123',
                     taxvat: CPF.generate(true))
  end

  test 'should be valid cpf' do
    assert @user.valid?
  end

  test 'should be valid cnpj' do
    @user.taxvat = CNPJ.generate(true)
    assert @user.valid?
  end

  test 'should be invalid cpf' do
    @user.taxvat = '242.688.333-70'
    assert_not @user.valid?
  end

  test 'should be invalid cnpj' do
    @user.taxvat = '33.508.189/2221-87'
    assert_not @user.valid?
  end

  test 'taxvat attribute should be unique' do
    new_cpf = CPF.generate(true)
    first_user = User.new(name: 'AloAlo Teste',
                          email: 'aloalo@example', password: 'test123',
                          taxvat: new_cpf)
    first_user.save
    second_user = User.new(name: 'Teste AloAlo',
                           email: 'aloalo2@example', password: 'test123',
                           taxvat: new_cpf)
    assert_not second_user.valid?
  end
end
