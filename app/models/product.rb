class Product < ApplicationRecord
  include TimeModule

  validates :name, presence: true, uniqueness: true

  has_many :protocols, dependent: :destroy

  scope :exec_results, -> (product) {
    res = []
    product.protocols.each { |prot|
      # get testsuite's final result
      res.push([prot.name,
                Protocol.result(prot),
                Protocol.exec_time(prot)])
    }
    res
  }

  # Product's final result
  scope :result, -> (product) {
    res = []
    product.protocols.each { |prot|
      res.push(Protocol.result(prot))
    }
    if res.count("Pass") == res.length then
      "Pass"
    else
      "Fail"
    end
  }

  # total execution time for the protocol
  scope :exec_time, -> (product) {
    total_time = product.protocols.inject(0) { |sum,prot|
      second = TimeModule.convert_to_seconds(Protocol.exec_time(prot).to_time)
      sum += second
    }
    TimeModule.convert_to_time(total_time)
  }
end
