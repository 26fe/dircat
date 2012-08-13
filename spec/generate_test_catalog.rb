require 'fileutils'
require 'rubygems'
require 'RMagick'

class Generator

  def initialize
    @catalog_dir = File.expand_path File.join(File.dirname(__FILE__), %w{.. spec fixtures films})
  end

  def generate_folder_jpg(film, folder_filename)
    canvas = Magick::Image.new(240, 300,
                               Magick::HatchFill.new('white', 'lightcyan2'))
    gc     = Magick::Draw.new

    # Draw curve
    # gc.stroke('blue')
    # gc.stroke_width(3)
    # gc.fill_opacity(0)
    # gc.bezier(45, 150, 45, 20, 195, 280, 195, 150)

    # Draw endpoints
    # gc.stroke('gray50')
    # gc.stroke_width(1)
    # gc.circle(45, 150, 49, 150)
    # gc.circle(195, 150, 199, 150)

    # Draw control points
    # gc.fill_opacity(1)
    # gc.fill('gray50')
    # gc.circle(45, 17, 49, 17)
    # gc.circle(195, 280, 199, 280)

    # Connect the points
    # gc.line(45, 150, 45, 17)
    # gc.line(195, 280, 195, 150)

    # Annotate
    # gc.stroke('transparent').fill('black')
    # gc.text(27, 175, "'45,150'")
    # gc.text(175, 138, "'195,150'")
    # gc.text(55, 22, "'45,20'")
    # gc.text(143, 285, "'195,280'")
    gc.pointsize(20)
    gc.text_align(Magick::CenterAlign)
    gc.text(100, 50, film)
    gc.draw(canvas)

    canvas.write(folder_filename)
    puts "write '#{folder_filename}'"
  end

  def generate(dirname)
    dirname  = File.join(@catalog_dir, dirname)
    FileUtils.mkdir_p(dirname) unless File.exists?(dirname)
    folder_filename = File.join(dirname, "folder.jpg")
    generate_folder_jpg(File.basename(dirname), folder_filename)
  end

  def run
    generate("A-Z/A/Arancia meccanica [Stanley Kubrick][1971]")
    generate("A-Z/P/Plan 9 [Edward Wood][1959]")

    generate("Directors/[Akira Kurosawa]/[1940] Dersu Uzala [5]")
    generate("Directors/[Akira Kurosawa]/[1965] Barbarossa [Toshiro Mifune][4]")
    generate("Directors/[Federico Fellini]/[1963] 8 e mezzo [Marcello Mastroianni][Claudia Cardinale][5]")
    generate("Directors/[Woody Allen]/[1977] Annie Hall [Diane Keaton][5]")
  end

end

Generator.new.run
