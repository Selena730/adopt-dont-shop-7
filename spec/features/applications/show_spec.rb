require 'rails_helper'

RSpec.describe 'Applications Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
      @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
      @application_1 = Application.create!(name: "Selena", address: "123 Street City State Zip", adopting_reason: "Love for cats, no job", status:"Pending")
      @application_2 = Application.create!(name: "Laura", address: "58 Street City State Zip", adopting_reason: "Need company", status:"Rejected")
      @application_3 = Application.create!(name: "Isaac", address: "581 Street City State Zip", adopting_reason: "Lots of love to give", status:"Accepted")
      @application_pets_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      @application_pets_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
      @application_pets_3 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_3.id)
    end

    #User Story 1
    it "shows Applications Attributes" do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("Applicant name(s): #{@application_1.name}")
      expect(page).to have_content("Applicant address: #{@application_1.address}")
      expect(page).to have_content("Description of why the applicant says they'd be a good home for this pet(s): #{@application_1.adopting_reason}")
      expect(page).to have_content("Pets that this application is for: #{@pet_1.name}")
      # expect(page).to have_link("/pets/#{@pet_1.id}")
      expect(page).to have_content("Application's status: #{@application_1.status}")
    end
  end
end