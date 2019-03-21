# Wiched PDF

## Descrição

Biblioteca Ruby que utiliza o wkhtmltopdf para criação de arquivos PDF a partir de uma página HTML.

## Usabilidade

### Instalação
```
$ gem install wiched_pdf
$ gem install wkhtmltopdf-binary
```

OU

```
$ bundle add wiched_pdf
$ bundle add wkhtmltopdf-binary
```

### Exemplo

```
class ThingsController < ApplicationController
  def export
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name" # Sem a extensão .pdf
      end
    end
  end
end
```

## Vantagens

- Customização com html e css
- Helpers específicos do Rails para auxiliar na utilização de assets
- Baixa curva de aprendizagem
- Criação de um PDF se assemelha a criação de uma página comum no Rails

## Desvantagens

- Uso de webkit desatualizado, dificultando alguns customizações
- Para definir um cabeçalho e um rodapé para todas as páginas é necessário a criação de um arquivo para cada

## Custo de implementação

- Necessidade de refazer todos os relatórios
- De 1 a 2 horas de implementação para cada relatório

## Performance

- Desempenho impressionante, chegando a gerar um relatório de mais de 100 páginas em poucos segundos.

## Custo Financeiro

- R$ 0,00