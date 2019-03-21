class CollaboratorsController < ApplicationController
  require 'benchmark'
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]
  LIMIT = 277

  # GET /collaborators
  # GET /collaborators.json
  def index
    @collaborators = Collaborator.limit(LIMIT)
  end

  # GET /collaborators/1
  # GET /collaborators/1.json
  def show
  end

  # GET /collaborators/new
  def new
    @collaborator = Collaborator.new
  end

  # GET /collaborators/1/edit
  def edit
  end

  # POST /collaborators
  # POST /collaborators.json
  def create
    @collaborator = Collaborator.new(collaborator_params)

    respond_to do |format|
      if @collaborator.save
        format.html { redirect_to @collaborator, notice: 'Collaborator was successfully created.' }
        format.json { render :show, status: :created, location: @collaborator }
      else
        format.html { render :new }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaborators/1
  # PATCH/PUT /collaborators/1.json
  def update
    respond_to do |format|
      if @collaborator.update(collaborator_params)
        format.html { redirect_to @collaborator, notice: 'Collaborator was successfully updated.' }
        format.json { render :show, status: :ok, location: @collaborator }
      else
        format.html { render :edit }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborators/1
  # DELETE /collaborators/1.json
  def destroy
    @collaborator.destroy
    respond_to do |format|
      format.html { redirect_to collaborators_url, notice: 'Collaborator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def export_with_prawn
    require 'prawn'

    pdf_options = {
      :page_layout => :portrait,
      :page_size => "A4",
      :skip_page_creation => false,
      :margin => [30, 50, 20, 30]
    }

    puts "Iniciando benchmark"
    @collaborators = Collaborator.limit(LIMIT)
    memory_before = GetProcessMem.new.mb
    benchmark = Benchmark.measure do
      Prawn::Document.new(pdf_options) do |pdf|
        pdf.repeat(:all) do
          pdf.draw_text 'H7DRA - Fila Ambulatorial - [FILA]', at: pdf.bounds.top_left
          pdf.draw_text '[Data]', at: pdf.bounds.top_right
        end
        pdf.table @collaborators.collect{ |c| [ c.name, c.salary ]}
        pdf.start_new_page
        pdf.render_file('public/pdf/collaborators-prawn-from-ruby.pdf')
      end
    end
    memory_after = GetProcessMem.new.mb
    memory_usage = memory_after - memory_before
    BenchmarkTest.create(
      description: 'Prawn',
      from: 'Ruby',
      quantity: LIMIT,
      url: '/pdf/collaborators-prawn-from-ruby.pdf',
      memory_usage: memory_usage,
      user_cpu_time: benchmark.utime,
      system_cpu_time: benchmark.stime,
      total_cpu_time: benchmark.cstime,
      real_cpu_time: benchmark.real
    )
    puts "Finalizando benchmark"
    redirect_to '/pdf/collaborators-prawn-from-ruby.pdf'
  end

  def export_with_wicked
    puts "Iniciando benchmark"
    @collaborators = Collaborator.limit(LIMIT)
    pdf = nil
    memory_before = GetProcessMem.new.mb
    benchmark = Benchmark.measure do
      pdf = render pdf: 'collaborators-wicked-from-html',
                   page_size: "Letter",
                   template: 'collaborators/report/content',
                   header: { html: { template: 'collaborators/report/header' } },
                   footer: { html: { template: 'collaborators/report/footer' } },
                   margin: {
                     top: 28,
                     right: 15,
                     bottom: 20,
                     left: 20
                   },
                   save_to_file: Rails.root.join('public/pdf', 'collaborators-wicked-from-html.pdf')
    end
    memory_after = GetProcessMem.new.mb
    memory_usage = memory_after - memory_before
    BenchmarkTest.create(
      description: 'Wicked',
      from: 'HTML',
      quantity: LIMIT,
      url: '/pdf/collaborators-wicked-from-html.pdf',
      memory_usage: memory_usage,
      user_cpu_time: benchmark.utime,
      system_cpu_time: benchmark.stime,
      total_cpu_time: benchmark.cstime,
      real_cpu_time: benchmark.real
    )
    puts "Finalizando benchmark"
    pdf
  end

  def export_with_pdfkit
    puts "Iniciando benchmark"
    @collaborators = Collaborator.limit(LIMIT)
    html = nil
    memory_before = GetProcessMem.new.mb
    benchmark = Benchmark.measure do
      html = render template: 'collaborators/export_with_wicked'
      kit = PDFKit.new(html[0], page_size: 'A4')
      kit.to_file Rails.root.join('public/pdf', 'collaborators-pdfkit-from-html.pdf')
    end
    memory_after = GetProcessMem.new.mb
    memory_usage = memory_after - memory_before
    BenchmarkTest.create(
      description: 'PDFKit',
      from: 'HTML',
      quantity: LIMIT,
      url: '/pdf/collaborators-pdfkit-from-html.pdf',
      memory_usage: memory_usage,
      user_cpu_time: benchmark.utime,
      system_cpu_time: benchmark.stime,
      total_cpu_time: benchmark.cstime,
      real_cpu_time: benchmark.real
    )
    puts "Finalizando benchmark"
    html
  end

  def export_with_libreconv
    puts "Iniciando benchmark"
    @collaborators = Collaborator.limit(LIMIT)
    html = nil
    memory_before = GetProcessMem.new.mb
    report_file_name = ''
    benchmark = Benchmark.measure do
      report_file_name = prepare_odt(@collaborators)
      Libreconv.convert("tmp/#{report_file_name}.odt", 'public/pdf/')
    end
    memory_after = GetProcessMem.new.mb
    memory_usage = memory_after - memory_before
    BenchmarkTest.create(
      description: 'Libreconv',
      from: 'ODT',
      quantity: LIMIT,
      url: '/pdf/fila-ambulatorial-libreconv-from-odt.pdf',
      memory_usage: memory_usage,
      user_cpu_time: benchmark.utime,
      system_cpu_time: benchmark.stime,
      total_cpu_time: benchmark.cstime,
      real_cpu_time: benchmark.real
    )
    puts "Finalizando benchmark"
    send_file("public/pdf/fila-ambulatorial-libreconv-from-odt.pdf")
  end

  def export_with_docsplit
    puts "Iniciando benchmark"
    @collaborators = Collaborator.limit(LIMIT)
    html = nil
    memory_before = GetProcessMem.new.mb
    report_file_name = ''
    benchmark = Benchmark.measure do
      report_file_name = prepare_odt(@collaborators)
      Docsplit.extract_pdf(Rails.root.join('tmp', "#{report_file_name}.odt").to_s, output: "tmp/")
    end
    memory_after = GetProcessMem.new.mb
    memory_usage = memory_after - memory_before
    BenchmarkTest.create(
      description: 'Docsplit',
      from: 'ODT',
      quantity: LIMIT,
      url: '/pdf/fila-ambulatorial-docsplit-from-odt.pdf',
      memory_usage: memory_usage,
      user_cpu_time: benchmark.utime,
      system_cpu_time: benchmark.stime,
      total_cpu_time: benchmark.cstime,
      real_cpu_time: benchmark.real
    )
    puts "Finalizando benchmark"
    send_file("tmp/#{report_file_name}.pdf")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaborator
      @collaborator = Collaborator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collaborator_params
      params.require(:collaborator).permit(:name, :salary, :created_at)
    end

    def prepare_odt(collaborators)
      report = ODFReport::Report.new("app/reports/FILA_AMBULATORIAL.odt") do |r|
        r.add_field :data_relatorio, l(DateTime.now)
        r.add_field :filtros,        'Sexo: Masculino; Idade de: 10; Idade at: 20'
        r.add_field :fila, "Fila de Espera"
        r.add_field :total, 10
  
        r.add_table("internacoes", collaborators, :header => false) do |p|
          p.add_column(:nome_codigo) {|i| i.name }
          p.add_column(:cartao)      {|i| i.salary }
          p.add_column(:idade)       {|i| i.created_at }
          p.add_column(:sexo)        {|i| i.created_at }
          p.add_column(:origem)      {|i| i.created_at }
          p.add_column(:status)      {|i| i.created_at }
          p.add_column(:rmt)         {|i| i.created_at }
          p.add_column(:desde)       {|i| i.created_at }
  
          p.add_column(:espera) do |i|
            dias = (Date.today - i.created_at.to_date).to_i
            "#{l(i.created_at, format: '%d/%m/%Y')} (#{dias} dias)"
          end
          p.add_column(:especialidade) do |i| 
            "#{i.especialidade_leito.try(:descricao)} / #{i.categoria_leito_text}" rescue "" 
          end
          p.add_column(:prioridade)   {|i| i.salary }
          p.add_column(:carater)      {|i| i.salary }
          p.add_column(:solicitante)  {|i| i.name}
          p.add_column(:operador)     {|i| i.name }
  
          p.add_column(:cid)               {|i| i.salary }
          p.add_column(:descricao_clinica) {|i| i.name }
        end
      end
      timestamp = Time.new.strftime("%Y%m%d%H%M%S")
      report_file_name = "fila_ambulatorial_#{timestamp}"
      report_file_path = Rails.root.join('tmp', "#{report_file_name}.odt").to_s
      report.generate(report_file_path)
      report_file_name
    end
end
