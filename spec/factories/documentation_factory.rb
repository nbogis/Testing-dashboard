FactoryGirl.define do
  factory :documentation do
    body "Documntation body"

    protocol

    factory :protocol_documentation do
      association :documentable, factory: protocol
    end

  end

end
