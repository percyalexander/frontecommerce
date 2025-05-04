# Etapa 1: Build de la app React
FROM node:18 AS builder

# Crear directorio de trabajo
WORKDIR /front

# Copiar package.json e instalar dependencias
COPY . .

RUN npm install

# Construir la app
RUN npm run build


# Etapa 2: Servir con NGINX
FROM nginx:1.24.0

# Elimina la configuración por defecto de NGINX

# Copia el build generado por React
COPY --from=builder /front /usr/share/nginx/html

# Copia una configuración básica personalizada de NGINX (opcional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Exponer puerto por defecto de NGINX
EXPOSE 5000

# Comando por defecto
CMD ["nginx", "-g", "daemon off;"]
