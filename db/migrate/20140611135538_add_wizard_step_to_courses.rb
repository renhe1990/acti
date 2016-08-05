class AddWizardStepToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :wizard_step, :integer
  end
end
