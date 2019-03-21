# PDFkit

## Descrição

Biblioteca Ruby que utiliza o wkhtmltopdf para criação de arquivos PDF a partir de uma página HTML.

## Usabilidade

### Instalação
```
$ gem install pdfkit
$ gem install wkhtmltopdf-binary
```

OU

```
$ bundle add pdfkit
$ bundle add wkhtmltopdf-binary
```

### Exemplo

```
class ThingsController < ApplicationController
  def export
    html = render_to_string 'reports/example', :layout => false # Template file in views
    kit = PDFKit.new(html, page_size: 'Letter')
    kit.to_file '<path>/<file_name>.pdf'
    redirect_to '<url>/<file_name>.pdf'
  end
end
```

OU

```
class ThingsController < ApplicationController
  def export
    respond_to do |format|
      format.html
      format.pdf
    end
  end
end
```
Adicione nos inicializadores o arquivo pdfkit.rb
```
# config/initializers/pdfkit.rb
PDFKit.configure do |config|
  config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  config.default_options = {
    :page_size => 'Legal',
    :print_media_type => true
  }
  # Use only if your external hostname is unavailable on the server.
  config.root_url = "http://localhost"
  config.verbose = false
end
```
Adicione no arquivo application.rb
```
require 'pdfkit'

config.middleware.use PDFKit::Middleware
```
## Vantagens

- Customização com html e css
- Baixa curva de aprendizagem
- Criação de um PDF se assemelha a criação de uma página comum no Rails

## Desvantagens

- Uso de webkit desatualizado, dificultando alguns customizações

## Custo de implementação

- Necessidade de refazer todos os relatórios
- De 1 a 3 horas de implementação para cada relatório

## Performance

- Desempenho impressionante, chegando a gerar um relatório de mais de 100 páginas em poucos segundos.

## Custo Financeiro

- R$ 0,00