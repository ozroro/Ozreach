module Recruiter::ApplicantsHelper
  def status_options
    Seeker::Applicant::STATUS_STRINGS.map.with_index {|num, index| [num, index] }
  end
end
