# Projeto Integrador

Este é um projeto [Next.js](https://nextjs.org/) inicializado com [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Primeiros Passos

_Requisito: [Docker](docker.com)_

Defina a variável de ambiente `PORTA` em um arquivo `.env`, na raíz do diretório. Ex:

`PORTA=3000`

O servidor servirá na porta `3000` nesse caso.

No diretório raíz, construa o projeto:

`docker compose build`

Crie e inicie o container:

`docker compose up`

Abra [http://localhost:3000](http://localhost:3000) (caso `PORTA=3000`) no seu navegador para ver o resultado.

Você pode começar a editar a página modificando `app/page.tsx`. A página é atualizada automaticamente conforme você edita o arquivo.

### Sem Docker

Execute o servidor de desenvolvimento:

```bash
npm run dev
# ou
yarn dev
# ou
pnpm dev
```

Abra [http://localhost:3000](http://localhost:3000) no seu navegador para ver o resultado.

---

Este projeto utiliza [`next/font`](https://nextjs.org/docs/basic-features/font-optimization) para otimizar e carregar automaticamente a fonte Inter, uma fonte personalizada do Google.

## Saiba Mais

Para aprender mais sobre o Next.js, dê uma olhada nos seguintes recursos:

- [Documentação do Next.js](https://nextjs.org/docs) - saiba mais sobre os recursos e a API do Next.js.
- [Aprenda Next.js](https://nextjs.org/learn) - um tutorial interativo do Next.js.

Você também pode conferir [o repositório do Next.js no GitHub](https://github.com/vercel/next.js/) - seu feedback e contribuições são bem-vindos!

## Deploy on Vercel

A maneira mais fácil de implantar seu aplicativo Next.js é usar a [Plataforma Vercel](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) dos criadores do Next.js.

Confira nossa [documentação de implantação do Next.js](https://nextjs.org/docs/deployment) para mais detalhes.
