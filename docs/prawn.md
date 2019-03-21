# Prawn

## Descrição

Biblioteca Ruby para criação e manipulação de arquivos em PDF

## Usabilidade

### Instalação

```
$ gem install prawn-rails
```
OU
```
$ bundle add prawn-rails
```

### Exemplo

```
require 'prawn'

PDF_OPTIONS = {
  :page_layout => :portrait,
  :page_size => "LETTER",
  :margin => [50, 50, 50, 50] # Valores em milímetros
}

Prawn::Document.new(PDF_OPTIONS) do |pdf|
  pdf.text 'Texto'
  pdf.render_file('public/pdf/collaborators-prawn-from-ruby.pdf') # Arquivo de destino
end

```

## Vantagens

- Customização precisa
- Comunidade forte e ativa

## Desvantagens

- Alta curva de aprendizagem
- Performance para gerar relatórios com muitas páginas
- Necessário a instalação de gemas extras para alguns elementos necessários. Ex: Tabelas

## Custo de implementação

- Estudo dos componentes para customização
- Pelo menos 4 horas de implementação para cada relatório

## Performance

- Ideal para relatórios de poucas páginas
- Vários minutos para relatórios de 50 páginas

## Custo Financeiro

- R$ 0,00