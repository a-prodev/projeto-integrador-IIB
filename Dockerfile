FROM node:18-alpine AS base

# Instalar dependências apenas quando necessário
FROM base AS deps
# Verifique em https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine para entender por que libc6-compat pode ser necessário.
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Instalar dependências com base no gerenciador de pacotes preferido
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN \
	if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
	elif [ -f package-lock.json ]; then npm ci; \
	elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i --frozen-lockfile; \
	else echo "Lockfile não encontrado." && exit 1; \
	fi


# Reconstruir o código-fonte apenas quando necessário
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# O Next.js coleta dados de telemetria completamente anônimos sobre o uso geral.
# Saiba mais aqui: https://nextjs.org/telemetry
# Descomente a linha a seguir caso queira desabilitar a telemetria durante a compilação.
ENV NEXT_TELEMETRY_DISABLED 1

RUN yarn build

# Se estiver usando o npm, comente a seção acima e use a abaixo em seu lugar
# RUN npm run build

# Imagem de produção, copie todos os arquivos e execute o Next.js
FROM base AS runner
WORKDIR /app

ENV NODE_ENV production
# Descomente a linha a seguir caso queira desabilitar a telemetria durante a execução.
ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public

# Aproveite automaticamente os rastreamentos de saída para reduzir o tamanho da imagem
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["node", "server.js"]
