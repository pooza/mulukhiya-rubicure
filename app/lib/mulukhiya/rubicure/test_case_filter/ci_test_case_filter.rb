module Mulukhiya
  module Rubicure
    class CITestCaseFilter < TestCaseFilter
      def active?
        return Environment.ci?
      end
    end
  end
end
