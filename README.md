# Projeto Bananeiras

Aplicação pessoal para gestão de compras, stock, transferências e aplicações de produtos em terrenos agrícolas, com interface gráfica usando `ttkbootstrap` e base de dados Supabase.

## ✅ Requisitos

- Python 3.x instalado
- Git instalado e configurado
- Conta no Supabase com uma base de dados configurada

## 📦 Instalação de dependências

Instalação de ambiente virtual e dependências necessárias:

```bash
python -m venv venv
.\venv\Scripts\activate
pip install supabase ttkbootstrap python-dotenv
```

## 🔐 Variáveis de ambiente
Cria um ficheiro .env na raiz do projeto com o seguinte conteúdo:
```bash
SUPABASE_URL=https://exemplo.supabase.co
SUPABASE_KEY=chave_secreta_aqui
```

## 🧪 Execução da aplicação
Para correr a aplicação no terminal:
```bash
python main.py
```

## 🛠️ Compilação para .exe
Para criar um executável da aplicação:
```bash
pip install pyinstaller
pyinstaller --onefile --noconsole main.py
```

O ficheiro .exe ficará disponível em dist/main.exe.

Sempre que fizeres alterações ao código, precisas de correr novamente o comando acima para atualizar o .exe.

## 🐍 Estrutura do Projeto
```bash
Bananeiras/
│
├── main.py
├── .env
├── .gitignore
├── README.md
├── requirements.txt (opcional)
└── venv/
```
