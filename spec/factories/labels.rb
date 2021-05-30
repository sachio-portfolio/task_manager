FactoryBot.define do
  factory :label, class: Label do
    label_name { "ラベル１" }
  end
  factory :second_label, class: Label do
    label_name { "ラベル２" }
  end
  factory :third_label, class: Label do
    label_name { "ラベル３" }
  end
end
