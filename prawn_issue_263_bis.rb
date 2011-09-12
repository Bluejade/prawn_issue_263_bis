# encoding: UTF-8

require 'prawn'

Prawn::Document.generate "prawn_issue_263_example.pdf" do |pdf|
  pdf.font_families.update("Calibri" => {
    :normal => File.expand_path('../lib/Calibri.ttf', __FILE__),
    :italic => File.expand_path('../lib/Calibri Italic.ttf', __FILE__),
    :bold => File.expand_path('../lib/Calibri Bold.ttf', __FILE__),
    :bold_italic => File.expand_path('../lib/Calibri Bold Italic.ttf', __FILE__)
  })
  
  # Comment this line in order to print the second cell in bold
  pdf.fallback_fonts ["Calibri"]
  
  pdf.table [["Following cell must be bold", "PDF for ISSUE 263"]], cell_style: { height: 60 } do
    row(0).column(0).width = 115
    row(0).column(1).width = 230
    
    # This prints the second cell in bold
    row(0).column(1).font_style = :bold
    
    row(0).column(1).size = 14
    row(0).columns(0..1).align, row(0).columns(0..1).valign = :center, :center
  end
  
  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 82], width: pdf.bounds.width do
    # This cell contains some π glyphes that the default Helvetica font can't print: Calibri is needed
    question_cell = "Which is the L value if L is the subject of the formulae 2πfL = x?\n\nA L = 2πf\nB L = 2πf / x\nC L = x / 2πf"
    pdf.table [["1", question_cell]]
  end
end
