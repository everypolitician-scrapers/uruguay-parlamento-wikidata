#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'wikidata/fetcher'

cddu = 'Categoría:Diputados de Uruguay'
depts = [
  'Artigas', 'Canelones', 'Cerro Largo', 'Colonia', 'Durazno', 'Flores',
  'Florida', 'Lavalleja', 'Maldonado', 'Montevideo', 'Paysandú',
  'Rivera', 'Rocha', 'Río Negro', 'Salto', 'San José', 'Soriano',
  'Tacuarembó', 'Treinta y Tres'
]
categories = depts.map { |d| "#{cddu} por #{d}" } + [cddu]

en_names = WikiData::Category.new('Category:Members of the Chamber of Deputies of Uruguay', 'en').member_titles
es_names = categories.flat_map { |c| WikiData::Category.new(c, 'es').member_titles }.uniq
EveryPolitician::Wikidata.scrape_wikidata(names: { es: es_names, en: en_names })
