class PromotionalRule
  def applicable?(resource)
    raise "sub classes to define eligibility criteria"
  end

  def apply
    raise "sub classes to give the total value of the checkout based on this"
  end
end