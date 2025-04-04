# 🧠 ActiveBuddy – AI-assisted Model Validator for Rails

**ActiveBuddy** is a professional-grade Ruby gem that intelligently analyzes your ActiveRecord models and suggests validations and associations based on column names, data types, constraints, and naming conventions.

Perfect for jump-starting new Rails projects with smart, conventional best-practice validations.

---

## 🎯 Features

- ✅ Smart inference of:
  - `presence`
  - `uniqueness`
  - `length`
  - `numericality`
  - `format` validations
- 🧩 Association recommendations:
  - `belongs_to`, `has_many`, etc.
- 🔍 Custom rule engine based on Rails conventions and common model types (User, Payment, Account, etc.)
- 🔮 Expandable AI-based ruleset planned for future updates

---

## 🛠 Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_buddy'
```

And then execute:

```bash
bundle install
```

Or install it yourself as a standalone gem:

```bash
gem install active_buddy
```

---

## ⚡️ Usage

In your Rails app or console:

```ruby
require 'active_Buddy'

analyzer = ActiveBuddy::Analyzer.new(User)
puts analyzer.suggest_validations
puts analyzer.suggest_associations
```

Output:

```ruby
validates :email, presence: true
validates :email, uniqueness: true
validates :email, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/ }
validates :name, presence: true
belongs_to :account
```

---

## ✅ Supported Patterns

ActiveBuddy automatically picks up and suggests validations based on:

| Field Pattern       | Suggested Validations |
|---------------------|------------------------|
| `email`             | format, presence, uniqueness |
| `phone`, `mobile`   | phone format |
| `name`, `title`     | presence, length |
| `password`          | length (>= 6) |
| `age`, `count`, `qty` | numericality (integer) |
| `price`, `amount`   | numericality (>= 0) |
| `bio`, `description`| length (max 1000) |
| `status`, `role`, `type` | presence |

Also detects and formats associations from ActiveRecord relationships.

---

## 🧪 Run Specs

```bash
bundle exec rspec
```

---