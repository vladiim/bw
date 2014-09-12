class Photographer < Sequel::Model

  one_through_one :article
  one_to_one :account

  # has profile image as image_id

  attr_reader :account
  def initialize
    @account = Account.new
    account.role = 'photographer'
  end

  def name=(name)
    account.name = name
  end

  def save(super_proc = ->{ super })
    account.save
    
  end

end
