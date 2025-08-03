from supabase import create_client
from tkinter import ttk
import ttkbootstrap as tb
from dotenv import load_dotenv
import os

# SEMPRE QUE FIZER ALTERAÇÕES CORRER ESTE COMANDO
#pyinstaller --noconsole --onefile main.py

load_dotenv()

url = os.getenv("SUPABASE_URL") 
key = os.getenv("SUPABASE_KEY")

supabase = create_client(url, key)

WINDOW_SIZE="600x500"
TABELA_SIZE_SMALL="500x100"
TABELA_SIZE_MEDIUM="800x600"
TABELA_SIZE_BIG="1000x600"


# === FUNÇÕES DE LISTAGEM ===
def listar_stock():
    res = supabase.table("stockporprodutoarmazem").select("*").execute()
    titulo = "Stock por Produto e Armazém"
    colunas = ["armazem", "tipo_produto", "produto", "quantidade"]

    mostrar_tabela(titulo, res.data, colunas, TABELA_SIZE_BIG)


def total_aplicado_ano():
    def submeter():
        ano = entry_ano.get()
        if not ano.isdigit():
            mostrar_erro("Insere um ano numérico.")
            return

        res = supabase.table("totalaplicadoanokg").select("*").eq("ano", int(ano)).execute()
        if not res.data:
            mostrar_info("Sem resultados", "Não foram encontrados dados para esse ano.")
            return
        janela.destroy()
        titulo = f"Total Aplicado no Ano {ano}"
        colunas = ["tipo_produto", "total_kg"]
        mostrar_tabela(titulo, res.data, colunas, TABELA_SIZE_SMALL)

    janela = criar_janela("Total Aplicado por Ano")

    lbl = ttk.Label(janela, text="Insere o ano:")
    lbl.pack(pady=10)

    entry_ano = ttk.Entry(janela)
    entry_ano.pack(pady=5)

    btn = ttk.Button(janela, text="Submeter", command=submeter)
    btn.pack(pady=10)


def valor_aplicado_terreno():
    res = supabase.table("valoraplicadoporterreno").select("*").execute()
    titulo = "Valor Aplicado por Terreno"
    colunas = ["temporada", "terreno", "produto", "total_kg"]
    mostrar_tabela(titulo, res.data, colunas, TABELA_SIZE_BIG)


def valor_aplicado_terreno_ano():
    def submeter():
        ano = entry.get()
        if not ano.isdigit():
            mostrar_erro("Insere um ano válido.")
            return
        janela.destroy()
        res = supabase.table("valoraplicadoporterreno").select("*").eq("ano", int(ano)).execute()
        if not res.data:
            mostrar_info("Sem dados", "Não há dados para esse ano.")
            return
        titulo = f"Valor Aplicado por Terreno - Ano {ano}"
        colunas = ["terreno", "produto", "total_kg"]
        mostrar_tabela(titulo, res.data, colunas, TABELA_SIZE_MEDIUM)

    janela = criar_janela("Filtrar por Ano")

    entry = criar_input("Insere o ano:", janela)

    ttk.Button(janela, text="Submeter", command=submeter).pack(pady=10)


def valor_aplicado_terreno_temporada():
    def submeter():
        temporada = entry.get().strip()
        if not temporada:
            mostrar_erro("Insere uma temporada válida.")
            return
        janela.destroy()
        res = supabase.table("valoraplicadoporterreno").select("*").eq("temporada", temporada).execute()
        
        if not res.data:
            mostrar_info("Sem dados", "Não há dados para essa temporada.")
            return
        titulo = f"Valor Aplicado por Terreno - Temporada {temporada}"
        colunas = ["terreno", "produto", "total_kg"]
        mostrar_tabela(titulo, res.data, colunas, TABELA_SIZE_MEDIUM)

    janela = criar_janela("Filtrar por Temporada")

    entry = criar_input("Insere a temporada:", janela)

    ttk.Button(janela, text="Submeter", command=submeter).pack(pady=10)


def listar_transferencias():
    res = supabase.table("transferenciasporarmazem").select("*").execute()
    titulo = "Histórico de Transferências"
    colunas = ["data", "armazem", "produto", "quantidade"]
    mostrar_tabela(titulo, res.data, colunas, TABELA_SIZE_BIG)


def mostrar_tabela(titulo, dados, colunas, tamanho_tabela):
    root = tb.Window(themename="flatly")
    root.title(titulo)
    root.geometry(tamanho_tabela)

    style = ttk.Style(root)
    style.configure("Treeview.Heading", font=("Segoe UI", 12, "bold"))
    style.configure("Treeview", font=("Segoe UI", 10))
    tree = ttk.Treeview(root, columns=colunas, show="headings", style="Treeview")
    tree["show"] = "headings"
    tree["selectmode"] = "browse"

    for col in colunas:
        tree.heading(col, text=col.capitalize())
        tree.column(col, anchor="center", width=150)

    # Inserir linhas com alternância de fundo
    for i, row in enumerate(dados):
        tag = "odd" if i % 2 == 0 else "even"
        tree.insert("", "end", values=[row.get(c, "") for c in colunas], tags=(tag,))

    # Cores de fundo alternadas
    tree.tag_configure("odd", background="#f9f9f9")
    tree.tag_configure("even", background="#e0e0e0")

    tree.pack(fill="both", expand=True)
    root.mainloop()


# === FUNÇÕES DE INSERIR VALORES ===
def inserir_compra():
    def submeter():
        produto = entry_produto.get()
        quantidade = entry_quantidade.get()
        data = entry_data.get()
        if not produto or not quantidade or not data:
            mostrar_erro("Preenche todos os campos.")
            return
        try:
            quantidade = int(quantidade)
        except ValueError:
            mostrar_erro("Quantidade inválida.")
            return

        try:
            res = supabase.rpc("InserirCompra", {
                "p_produtonome": produto,
                "p_quantidade": quantidade,
                "p_data": data
            }).execute()
            mostrar_sucesso("Compra inserida com sucesso.")
            janela.destroy()
        except Exception as e:
            mostrar_erro(str(e))

    janela = criar_janela("Inserir Compra")

    entry_produto = criar_opcao_input("Produto:", criar_opcoes("produto", "nome"), janela)
    entry_quantidade = criar_input("Quantidade (sacos):", janela)
    entry_data = criar_input("Data (YYYY-MM-DD):", janela)

    btn = ttk.Button(janela, text="Submeter", command=submeter)
    btn.pack(pady=15)


def inserir_transferencia():
    def submeter():
        armazem = entry_arm.get()
        produto = entry_prod.get()
        quantidade = entry_qtd.get()
        data = entry_data.get()
        try:
            qtd = float(quantidade)
        except:
            mostrar_erro("Verifica os campos.")
            return

        try:
            supabase.rpc("InserirTransferencia", {
                "p_armazem_destino": armazem,
                "p_produtonome": produto,
                "p_quantidade": qtd,
                "p_data": data
            }).execute()
            mostrar_sucesso("Transferência inserida.")
            janela.destroy()
        except Exception as e:
            mostrar_erro(str(e))

    janela = criar_janela("Inserir Transferência")

    entry_arm = criar_opcao_input("Armazém destino:", criar_opcoes("armazem", "nome"), janela)
    entry_prod = criar_opcao_input("Produto:", criar_opcoes("produto", "nome"), janela)
    entry_qtd = criar_input("Quantidade (sacos):", janela)
    entry_data = criar_input("Data (YYYY-MM-DD):", janela)

    ttk.Button(janela, text="Submeter", command=submeter).pack(pady=10)


def inserir_stock():
    def submeter():
        armazem = entry_arm.get()

        produto = entry_prod.get()
        quantidade = entry_qtd.get()
        try:
            qtd = float(quantidade)
        except:
            mostrar_erro("A quantidade tem de ser numérica.")
            return

        try:
            supabase.rpc("InserirStock", {
                "p_armazem": armazem,
                "p_produtonome": produto,
                "p_quantidade": qtd
            }).execute()
            mostrar_sucesso("Stock inserido/atualizado.")
            janela.destroy()
        except Exception as e:
            mostrar_erro(str(e))

    janela = criar_janela("Inserir Stock")

    entry_arm = criar_opcao_input("Armazém:", criar_opcoes("armazem", "nome"), janela)
    entry_prod = criar_opcao_input("Produto:", criar_opcoes("produto", "nome"), janela)
    entry_qtd = criar_input("Quantidade (sacos):", janela)

    ttk.Button(janela, text="Submeter", command=submeter).pack(pady=10)


def inserir_aplicacao():
    def submeter():
        temporada = entry_temporada.get()
        terreno = entry_terreno.get()
        produto = entry_produto.get()
        data = entry_data.get()
        stock_final = entry_stock_final.get()

        try:
            qtd = float(stock_final)
        except:
            mostrar_erro("Número inválido")
            return

        try:
            supabase.rpc("InserirAplicacao", {
                "p_temporada": temporada,
                "p_terrenonome": terreno,
                "p_produtonome": produto,
                "p_data": data,
                "p_stock_final": qtd
            }).execute()
            mostrar_sucesso("Aplicação inserida.")
            janela.destroy()
        except Exception as e:
            mostrar_erro(str(e))

    janela = criar_janela("Inserir Aplicação")

    entry_temporada = criar_input("Temporada:", janela)
    entry_terreno = criar_opcao_input("Terreno:", criar_opcoes("terreno", "nome"), janela)
    entry_produto = criar_opcao_input("Produto:", criar_opcoes("produto", "nome"), janela)
    entry_data = criar_input("Data (YYYY-MM-DD):", janela)
    entry_stock_final = criar_input("Stock Final (sacos):", janela)

    ttk.Button(janela, text="Submeter", command=submeter).pack(pady=10)


# === FUNÇÕES VISUAIS ===
def criar_input(mensagem, janela):
    ttk.Label(janela, text=mensagem).pack(pady=5)
    entry = ttk.Entry(janela)
    entry.pack(pady=5)
    return entry


def criar_opcao_input(mensagem, valores, janela):
    ttk.Label(janela, text=mensagem).pack(pady=5)
    combo = ttk.Combobox(janela, values=valores, state="readonly")
    combo.pack(pady=5)
    return combo


def criar_opcoes(nome_tabela, nome_coluna):
    res = supabase.table(nome_tabela).select(nome_coluna).execute()
    return sorted([p[nome_coluna] for p in res.data])


def criar_janela(mensagem):
    janela = tb.Toplevel()
    janela.title(mensagem)
    janela.geometry(WINDOW_SIZE)
    return janela

def mostrar_erro(msg):
    tb.dialogs.Messagebox.show_error(title="Erro", message=msg)

def mostrar_sucesso(msg):
    tb.dialogs.Messagebox.show_info(title="Sucesso", message=msg)

def mostrar_info(titulo, msg):
    tb.dialogs.Messagebox.show_info(title=titulo, message=msg)


def mostrar_interface():
    app = tb.Window(themename="flatly")
    app.title("Menu")
    app.geometry(WINDOW_SIZE)

    botoes = [
        ("Listar Stock", listar_stock),
        ("Total Aplicado por Ano (kg)", total_aplicado_ano),
        ("Valor Aplicado por Terreno", valor_aplicado_terreno),
        ("Valor Aplicado por Terreno (Ano)", valor_aplicado_terreno_ano),
        ("Valor Aplicado por Terreno (Temporada)", valor_aplicado_terreno_temporada),
        ("Histórico de Transferências", listar_transferencias),
        ("Inserir Compra", inserir_compra),
        ("Inserir Transferência", inserir_transferencia),
        ("Inserir Stock", inserir_stock),
        ("Inserir Aplicação", inserir_aplicacao),
    ]

    for texto, funcao in botoes:
        btn = ttk.Button(app, text=texto, command=funcao)
        btn.pack(pady=5, padx=20, fill="x")

    app.mainloop()

if __name__ == "__main__":
    mostrar_interface()
