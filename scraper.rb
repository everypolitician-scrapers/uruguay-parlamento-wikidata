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

query = <<SPARQL
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 [ ps:P39 wd:Q19930720 ; pq:P2937 ?term ] .
    ?term p:P31/pq:P1545 ?ordinal .
    FILTER (xsd:integer(?ordinal) >= 48)
  }
SPARQL
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { es: es_names, en: en_names })
