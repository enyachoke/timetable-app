class Pdf::Cell
  include ActiveAttr::MassAssignment

  attr_accessor :content, :colspan, :rowspan, :visibiliity, :lessons

  def initialize(args = {})
    super(args)

    @content     ||= ''
    @lessons     ||= []
    @colspan     ||= 1
    @rowspan     ||= 1
    @visibiliity ||= true
  end

  def to_h
    { :content => content, :colspan => colspan, :rowspan => rowspan }
  end

  def visibiliity?
    visibiliity
  end

  def content
    return lessons_content if lessons.any?

    @content
  end

  def ==(other_cell)
    return content == other_cell.content if lessons.empty? && other_cell.lessons.empty?
    return false unless lessons.count == other_cell.lessons.count

    lessons.each_with_index do |lesson, index|
      other_lesson = other_cell.lessons[index]

      return false unless lesson.discipline == other_lesson.discipline &&
        lesson.kind == other_lesson.kind &&
        lesson.classrooms == other_lesson.classrooms &&
        lesson.lecturers == other_lesson.lecturers
    end

    true
  end

  private

  def max_string_width
    20 * colspan
  end

  def lesson_title_or_abbr(lesson)
    lesson.discipline.title.size > max_string_width ? lesson.discipline.abbr : lesson.discipline.title
  end

  def lesson_lecturers(lesson)
    ''.tap do |string|
      string << lesson.lecturers.first.to_s

      return string if string.size > max_string_width

      lesson.lecturers[1..-1].each do |lecturer|
        string << ', ...' and break if (string + lecturer.to_s).size > max_string_width
        string << ", #{lecturer.to_s}"
      end
    end
  end

  def lessons_content
    ''.tap do |content|
      lessons.each do |lesson|
        content << lesson_title_or_abbr(lesson)
        content << "\n"
        content << lesson.kind_text
        content << "\n"
        content << lesson.classrooms.map(&:to_s).join(', ') if lesson.classrooms.any?
        content << "\n"
        content << lesson_lecturers(lesson) if lesson.lecturers.any?
      end
    end
  end
end
