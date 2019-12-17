#!/usr/bin/ruby

#vCardファイルをtsvに変換する。vCardはSH-01Jのバックアップで作成。
#項目を漏れなく横に並べる。一部の項目は加工して別項目を作成

require 'nkf'

contacts = []
current_contact = {}

STDIN.each do |line|
  line.strip!

  next if line == "BEGIN:VCARD"

  if line == "END:VCARD"
    contacts.push(current_contact)
    current_contact = {}
    next
  end
  
  key, value = line.split(':',2)
  key.gsub!(/;.*/, '')
  value.gsub!(/;/, ' ')
  value.strip!

  (1..100).each do |i|
    unless current_contact.has_key?("#{key}#{i}")
      current_contact["#{key}#{i}"] = value
      break
    end
  end
  
  if key == 'N'
    family_n, given_n = value.split(/[ 　]/, 2)
    current_contact['FAMILY'] = family_n
    current_contact['GIVEN'] = given_n
  end
  
  if key == 'SOUND'
    sound_fw_kana = NKF.nkf('-w -X', value)
    sound_fw_kana.tr!('ぁ-ん','ァ-ン')
    current_contact['SOUND_KANA'] = sound_fw_kana
    
    family_kana, given_kana = sound_fw_kana.split(/[ 　]/, 2)
    current_contact['FAMILY_KANA'] = family_kana
    current_contact['GIVEN_KANA'] = given_kana
  end
end

keys_hash = {}
contacts.each do |contact|
  keys_hash.merge!(contact)
end

keys = keys_hash.keys

puts keys.join("\t")

contacts.each do |contact|
  keys.each do |key|
    print contact[key] || ''
    print "\t"
  end
  puts
end

