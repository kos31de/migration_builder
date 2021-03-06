require 'rails_helper'

RSpec.describe MigrationBuilder::Wizard do
  let(:wizard) { default_wizard }

  describe 'rename table' do
    it 'generates rename_table code' do
      prompt = FakePrompt.new([
        {
          expected_question: 'What would you like to do?',
          assert_options: -> options do
            expect(options).to include('Rename existing table')
          end,
          response: 'Rename existing table'
        },
        {
          expected_question: 'Which table?',
          response: 'menu_items'
        },
        {
          expected_question: 'New name:',
          response: 'tasty_menu_items'
        }
      ])

      wizard.collect_input(prompt: prompt)
      expect(wizard.filename).to eq('rename_menu_items_to_tasty_menu_items')
      expect(wizard.content).to eq("rename_table :menu_items, :tasty_menu_items")
    end
  end
end
