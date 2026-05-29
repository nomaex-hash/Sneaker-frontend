# --- Bước 1: Mượn một máy ảo có Maven để đóng gói code ---
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
# Lệnh này sẽ dọn rác và đóng gói thành file .jar
RUN mvn clean package -DskipTests

# --- Bước 2: Tạo môi trường chạy Java siêu nhẹ ---
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
# Copy file .jar từ Bước 1 sang đây
COPY --from=build /app/target/*.jar app.jar
# Mở cửa số 8080 để giao tiếp
EXPOSE 8080
# Lệnh khởi động Backend
ENTRYPOINT ["java","-jar","app.jar"]