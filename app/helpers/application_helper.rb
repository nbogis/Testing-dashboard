module ApplicationHelper
  include TimeModule
  
  def header(text)
    content_for(:header) { text.to_s }
  end

  def get_tree
    Product.includes(:protocols => {:testsuites => :testcases})
    # usage: a.first.protocols.first.testsuites.first.testcases.first
  end

end
