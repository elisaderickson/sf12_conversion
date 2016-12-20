# Elisa Derickson
# December 2016

# SF12_Fix.rb
# Reason: SF12 Responses from DB in the form of text-based answers that need to be converted to 
# numeric counterparts for interpretation/analysis in SF12 assessment software.

# Steps:

# open current SF12 sheet
# open a new .csv sheet to hold revised/corrected values
# create variables to capture and hold current value of each column in each row
# create variables to hold transformed value
# transform values according to case logic
  # on new ClinicNotesID, write transformed values to new sheet
  # reset all variables
  # go to next row

require 'csv'
require 'set'

def read_current_file(sf12_database_file)

$i = 0 

while $i < 1

    sf12_database_file.each do |sf12_database_file_row|

    userid_string = sf12_database_file_row['userid'].to_s

    current_recordid_string = sf12_database_file_row['recordid'].to_s 

   gh01_string = sf12_database_file_row['GH01'].to_s 

    pf02_string = sf12_database_file_row['PF02'].to_s

    pf04_string = sf12_database_file_row['PF04'].to_s 

    rp02_string = sf12_database_file_row['RP02'].to_s 
  
    rp03_string = sf12_database_file_row['RP03'].to_s   

    re02_string = sf12_database_file_row['RE02'].to_s 
    
    re03_string = sf12_database_file_row['RE03'].to_s

    bp02_string = sf12_database_file_row['BP02'].to_s

    mh03_string = sf12_database_file_row['MH03'].to_s

    vt02_string = sf12_database_file_row['VT02'].to_s

    mh04_string = sf12_database_file_row['MH04'].to_s

    sf02_string = sf12_database_file_row['SF02'].to_s


    surveydate_string = sf12_database_file_row['surveydate'].to_s

    timepoint_string = sf12_database_file_row['timepoint'].to_s

    
    problem_set_1 = [gh01_string]

    problem_set_2 = [pf02_string, pf04_string]

    problem_set_3 = [rp02_string, rp03_string, re02_string, re03_string, mh03_string, vt02_string, mh04_string, sf02_string]

    problem_set_4 = [bp02_string]


    transform_sf12_strings(problem_set_1, problem_set_2, problem_set_3, problem_set_4)

    reassign_sf12_variables(problem_set_1, problem_set_2, problem_set_3, problem_set_4, $new_gh01_string, $new_pf02_string, $new_pf04_string, $new_rp02_string, $new_rp03_string, $new_re02_string, $new_re03_string, $new_bp02_string, $new_mh03_string, $new_vt02_string, $new_mh04_string, $new_sf02_string)

    if current_recordid_string != $old_recordid_string
      write_to_new_file(userid_string, current_recordid_string, $new_gh01_string, $new_pf02_string, $new_pf04_string, $new_rp02_string, $new_rp03_string, $new_re02_string, $new_re03_string, $new_bp02_string, $new_mh03_string, $new_vt02_string, $new_mh04_string, $new_sf02_string, surveydate_string, timepoint_string)
      #change recordid for comparison purposes
      old_recordid_string = current_recordid_string
    end


  $i = $i + 1

end
end 
end



 def transform_sf12_strings(problem_set_1, problem_set_2, problem_set_3, problem_set_4)
  problem_set_1.each do |sf12_response|
  problem_set_1_index = problem_set_1.find_index(sf12_response)
  if sf12_response == "Excellent"
     problem_set_1[problem_set_1_index] = "1"
  elsif sf12_response == "Very good"
     problem_set_1[problem_set_1_index] = "2"
  elsif sf12_response == "Good"
     problem_set_1[problem_set_1_index] = "3"
elsif sf12_response == "Fair" 
    problem_set_1[problem_set_1_index] = "4"
  elsif sf12_response == "Poor"
     problem_set_1[problem_set_1_index] = "5"
     else 
    puts "no match found"
end

end 

 problem_set_2.each do |sf12_response|
  problem_set_2_index = problem_set_2.find_index(sf12_response)
  if sf12_response == "A lot"
     problem_set_2[problem_set_2_index] = "1"
  elsif sf12_response == "Little"
     problem_set_2[problem_set_2_index] = "2"
  elsif sf12_response == "No"
     problem_set_2[problem_set_2_index] = "3"
    else 
      puts "no match found"
end

end


problem_set_3.each do |sf12_response|
  problem_set_3_index = problem_set_3.find_index(sf12_response)
  if sf12_response == "All"
     problem_set_3[problem_set_3_index] = "1"
  elsif sf12_response == "Most"
     problem_set_3[problem_set_3_index] = "2"
  elsif sf12_response == "Some"
     problem_set_3[problem_set_3_index] = "3"
  elsif sf12_response == "Little"
     problem_set_3[problem_set_3_index] = "4"
  elsif sf12_response == "None"
    problem_set_3[problem_set_3_index] = "5"
    else 
      puts "no match found"
end

end

problem_set_4.each do |sf12_response|
  problem_set_4_index = problem_set_4.find_index(sf12_response)
  if sf12_response == "Not at all"
     problem_set_4[problem_set_4_index] = "1"
  elsif sf12_response == "Little"
     problem_set_4[problem_set_4_index] = "2"
  elsif sf12_response == "Moderately"
     problem_set_4[problem_set_4_index] = "3"
  elsif sf12_response == "Quite a bit"
     problem_set_4[problem_set_4_index] = "4"
  elsif sf12_response == "Extremely"
    problem_set_4[problem_set_4_index] = "5"   
    else 
    problem_set_4[problem_set_4_index] = "No Match"   
      puts "no match found"
end


return

end

end

 def reassign_sf12_variables(problem_set_1, problem_set_2, problem_set_3, problem_set_4, new_gh01_string, new_pf02_string, new_pf04_string, new_rp02_string, new_rp03_string, new_re02_string, new_re03_string, new_bp02_string, new_mh03_string, new_vt02_string, new_mh04_string, new_sf02_string)

    $new_gh01_string = problem_set_1[0] 

    $new_pf02_string = problem_set_2[0] 

    $new_pf04_string = problem_set_2[1]

    $new_rp02_string = problem_set_3[0] 

    $new_rp03_string = problem_set_3[1]

    $new_re02_string = problem_set_3[2]

    $new_re03_string = problem_set_3[3] 

    $new_mh03_string = problem_set_3[4]

    $new_vt02_string = problem_set_3[5]

    $new_mh04_string = problem_set_3[6]

    $new_sf02_string = problem_set_3[7]

    $new_bp02_string = problem_set_4[0]

    return $new_gh01_string, $new_pf02_string, $new_pf04_string, $new_rp02_string, $new_rp03_string, $new_re02_string, $new_re03_string, $new_bp02_string, $new_mh03_string, $new_vt02_string, $new_mh04_string, $new_sf02_string

  end 


$old_recordid_string = 0.to_s


def write_to_new_file(userid_string, recordid_string, new_gh01_string, new_pf02_string, new_pf04_string, new_rp02_string, new_rp03_string, new_re02_string, new_re03_string, new_bp02_string, new_mh03_string, new_vt02_string, new_mh04_string, new_sf02_string, surveydate_string, timepoint_string)
  puts 'writing to new file'
  CSV.open('sf12_corrected2.csv', 'a+') do |csv|
  csv << [userid_string, recordid_string, new_gh01_string, new_pf02_string, new_pf04_string, new_rp02_string, new_rp03_string, new_re02_string, new_re03_string, new_bp02_string, new_mh03_string, new_vt02_string, new_mh04_string, new_sf02_string, surveydate_string, timepoint_string]

  return
end
end

#read in needed .csv files
#note, this could be csv.read if needed to be held in memory
sf12_database_file = CSV.read('sf12_original.csv', headers:true)

sf12_corrected_file = CSV.open('sf12_corrected2.csv', 'a+') do |csv|
csv << ['UserID' , 'recordid', 'GH01',  'PF02',  'PF04',  'RP02',  'RP03',  'RE02',  'RE03',  'BP02',  'MH03',  'VT02',  'MH04',  'SF02',  'surveydate',  'timepoint']    
end                          

results = read_current_file(sf12_database_file)


