class User < ApplicationRecord
  validates :name, presence: true
  validates :birthdate, presence: true

  has_many :injections

  attr_reader :age

  after_initialize :calcul_age
  after_save :calcul_age

  # Note: Here I use Disease.first just to test. See README "(dans un soucis de garder ce test simple, on considère que le système ne traite que d’une maladie)"
  def verify(disease = Disease.first)
    user_injections = injections.where(disease: disease).order(:performed_at)

    case @age
    when 0...14
      lt14(user_injections)
    when 14...65
      gte14_lt65(user_injections)
    when 65...Float::INFINITY # In case of :)
      gt65(user_injections)
    else
      nil
    end
  end

  private

  def calcul_age
    return unless birthdate

    current_time = Time.now.to_date
    return if birthdate >= current_time

    @age ||= current_time.year - birthdate.year - ((current_time.month > birthdate.month || (current_time.month == birthdate.month && current_time.day >= birthdate.day)) ? 0 : 1)
  end

  # Un enfant (moins de 14 ans) ayant reçu 2 doses à 6 mois d’intervalles
  def lt14(user_injections)
    return if user_injections.size != 2
    
    first_injection = user_injections.first.performed_at
    last_injection = user_injections.last.performed_at
    number_of_months = (last_injection.year * 12 + last_injection.month) - (first_injection.year * 12 + first_injection.month)
    number_of_months == 6 # Question: Que faire si c'est 5 mois ou 7 mois ?
  end

  # Un adulte (entre 14 et 65 ans) ayant reçu 1 doses au cours des 36 derniers mois
  # Question: Que faire dans le cas ou il en a eu 2 ?
  def gte14_lt65(user_injections)
    user_injections.last.performed_at > (Time.now.to_date - 36.months)
  end

  # Une personne âgée (> 65 ans) ayant reçu 1 dose au cours des 12 derniers mois
  # Question: Que faire dans le cas ou il en a eu 2 ?
  def gt65(user_injections)
    user_injections.last.performed_at > (Time.now.to_date - 12.months)
  end
end
