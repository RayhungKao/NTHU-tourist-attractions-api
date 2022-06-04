# frozen_string_literal: true

require_relative '../spec_helper'

describe 'Test AddCollaboratorToProject service' do
  before do
    wipe_database

    DATA[:accounts].each do |account_data|
      NTHUtouristAttractions::Account.create(account_data)
    end

    project_data = DATA[:projects].first

    @owner = NTHUtouristAttractions::Account.all[0]
    @collaborator = NTHUtouristAttractions::Account.all[1]
    @project = NTHUtouristAttractions::CreateProjectForOwner.call(
      owner_id: @owner.id, project_data:
    )
  end

  it 'HAPPY: should be able to add a collaborator to a project' do
    NTHUtouristAttractions::AddCollaboratorToProject.call(
      email: @collaborator.email,
      project_id: @project.id
    )

    _(@collaborator.projects.count).must_equal 1
    _(@collaborator.projects.first).must_equal @project
  end

  it 'BAD: should not add owner as a collaborator' do
    _(proc {
      NTHUtouristAttractions::AddCollaboratorToProject.call(
        email: @owner.email,
        project_id: @project.id
      )
    }).must_raise NTHUtouristAttractions::AddCollaboratorToProject::OwnerNotCollaboratorError
  end
end
