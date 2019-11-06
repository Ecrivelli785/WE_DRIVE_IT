Money.locale_backend = :currency

MoneyRails.configure do |config|
  config.default_currency = :ars  # or :gbp, :usd, etc.
  # [...]
end
