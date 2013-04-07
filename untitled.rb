def is_prime(n)
  factors = (2...n).collect { |i| n % i == 0 }
  return factors.size == 0
end