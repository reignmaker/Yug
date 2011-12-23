# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[
	{ :title => "Митинг 10 декабря в Москве"},
	{ :title => "Выборы президента Южной Осетии"},
	{ :title => "Протесты и волнения после выборов в Госдуму"},
	{ :title => "Президентские выборы 2012"}].each do |s|
	Subject.find_or_create_by_title(s)
end