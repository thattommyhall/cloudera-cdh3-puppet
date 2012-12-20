#! /usr/bin/env ruby

a = %w[226 227 228 229 232 233 234 237 240 242 243 246 247 250 252 253].map{|i| "192.168.35.#{i}"}
b = %w[117 119 121].map{|i| "192.168.35.#{i}"}
c = %w[118 120].map{|i| "192.168.35.#{i}"}
d = %w[122 123 124].map{|i| "192.168.35.#{i}"}

result =  ARGV.map do |ip|
  if a.include?(ip)
    '/a'
  elsif b.include?(ip)
    '/b'
  elsif c.include?(ip)
    '/c'
  elsif d.include?(ip)
    '/d'
  else
    '/c'
  end
end

puts result.join(' ')
