class CreateMultimediaSurveyResponses < ActiveRecord::Migration
  def change
    create_table :multimedia_survey_responses do |t|
      t.integer :Q1_SQid, :Q1
   	  t.integer :Q2_SQid, :Q2
   	  t.integer :Q3_SQid, :Q3
   	  t.integer :Q4_SQid, :Q4
   	  t.integer :Q5_SQid, :Q5
   	  t.integer :Q6_SQid, :Q6
   	  t.integer :Q7_SQid, :Q7
   	  t.integer :Q8_SQid, :Q8
   	  t.integer :Q9_SQid, :Q9
   	  t.integer :Q10_SQid, :Q10
   	  t.integer :Q11_SQid, :Q11
   	  t.integer :Q12_SQid, :Q12
   	  t.integer :Q13_SQid, :Q13
   	  t.integer :Q14_SQid, :Q14
   	  t.integer :Q15_SQid, :Q15
   	  t.integer :Q16_SQid, :Q16 
   	  t.integer :Q17_SQid, :Q17
   	  t.integer :Q18_SQid, :Q18
   	  t.integer :Q19_SQid, :Q19
   	  t.integer :Q20_SQid, :Q20
   	  t.integer :Q21_SQid, :Q21
   	  t.integer :Q22_SQid, :Q22
   	  t.integer :Q23_SQid, :Q23

      t.timestamps null: false
    end
  end
end
