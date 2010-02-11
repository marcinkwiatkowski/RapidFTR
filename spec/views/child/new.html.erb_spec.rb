require 'spec_helper'

class Schema;
end

describe "children/new.html.erb" do

  describe "rendering new Child record"  do

    it "always outputs a form with a photo upload field" do
      Schema.stub(:get_schema).and_return(
              {:fields => []
              })

      render

      response.should have_selector("form", :method => "post", :enctype => "multipart/form-data") do |form|
        form.should have_selector("input[type='file'][name='child[photo]']")
      end

    end

    it "renders text fields" do
      Schema.stub(:get_schema).and_return(
              {:fields => [
                      {
                              :name => "age",
                              :type => "text_field"
                      },
                      {
                              :name => "last_known_location",
                              :type => "text_field"
                      }]
              })

      render

      response.should have_selector("form") do |form|
        form.should have_selector("label[for='child_last_known_location']")
        form.should have_selector("input[id='child_last_known_location'][type='text']")
        form.should have_selector("label[for='child_age']")
        form.should have_selector("input[id='child_age'][type='text']")
      end
    end

    it "renders repeating text fields, with a button for adding another one" do
      Schema.stub(:get_schema).and_return(
              {:fields => [
                      {
                              :name => "uncle_name",
                              :type => "repeatable_text_field"
                      }
              ]
              })

      render

      response.should have_selector("form") do |form|
        form.should have_selector("label[for^='child_uncle_name']") do |label|
          label.should contain "Uncle name"
        end
        form.should have_selector("input[name='child[uncle_name][]'][type='text']")

      end

      

    end

  end

end
