#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

en_names = WikiData::Category.new( 'Category:Members of the Chamber of Deputies of Uruguay', 'en').member_titles
es_names = WikiData::Category.new( 'Categoría:Diputados de Uruguay', 'es').member_titles
EveryPolitician::Wikidata.scrape_wikidata(names: { es: es_name, en: en_names }, output: false)
