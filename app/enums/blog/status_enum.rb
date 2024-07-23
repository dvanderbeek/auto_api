module Blog
  module StatusEnum
    extend DeclarativeEnum

    key :status
    name 'BlogPostStatus'

    define do
      pending value: 'pending'
      approved value: 'approved'
      rejected value: 'rejected'
    end
  end
end
