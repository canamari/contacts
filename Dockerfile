# Use a imagem base do Ruby
FROM ruby:3.1

# Instale as dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Configurar o diretório de trabalho
WORKDIR /app

# Copie o Gemfile e Gemfile.lock para a imagem
COPY Gemfile Gemfile.lock ./

# Instale as gemas
RUN bundle install

# Copie o restante do código da aplicação para a imagem
COPY . .

# Expor a porta da aplicação
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
