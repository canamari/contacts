class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless CPF.valid?(value)
      record.errors.add(attribute, "is invalid")
    end
  end
end
