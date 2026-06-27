-- CreateEnum
CREATE TYPE "MealType" AS ENUM ('BREAKFAST', 'LUNCH', 'SNACK', 'DINNER');

-- CreateEnum
CREATE TYPE "Unit" AS ENUM ('GRAM', 'KILOGRAM', 'MILLILITER', 'LITER', 'PIECE', 'SCOOP');

-- CreateEnum
CREATE TYPE "FoodCategory" AS ENUM ('PROTEIN', 'DAIRY', 'FRUIT', 'VEGETABLE', 'GRAIN', 'BEVERAGE', 'SUPPLEMENT', 'SNACK', 'OTHER');

-- CreateEnum
CREATE TYPE "InventoryLogType" AS ENUM ('PURCHASE', 'CONSUMPTION', 'ADJUSTMENT', 'EXPIRED');

-- CreateEnum
CREATE TYPE "ShoppingItemStatus" AS ENUM ('PENDING', 'PURCHASED', 'CANCELLED');

-- CreateTable
CREATE TABLE "Food" (
    "id" TEXT NOT NULL,
    "userProfileId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" "FoodCategory" NOT NULL,
    "defaultUnit" "Unit" NOT NULL,
    "calories" DECIMAL(10,2) NOT NULL,
    "protein" DECIMAL(10,2) NOT NULL,
    "carbs" DECIMAL(10,2) NOT NULL,
    "fat" DECIMAL(10,2) NOT NULL,
    "price" DECIMAL(10,2),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Food_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Meal" (
    "id" TEXT NOT NULL,
    "userProfileId" TEXT NOT NULL,
    "mealType" "MealType" NOT NULL,
    "mealDate" TIMESTAMP(3) NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Meal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MealFood" (
    "id" TEXT NOT NULL,
    "mealId" TEXT NOT NULL,
    "foodId" TEXT NOT NULL,
    "quantity" DECIMAL(10,2) NOT NULL,
    "unit" "Unit" NOT NULL,
    "calories" DECIMAL(10,2) NOT NULL,
    "protein" DECIMAL(10,2) NOT NULL,
    "carbs" DECIMAL(10,2) NOT NULL,
    "fat" DECIMAL(10,2) NOT NULL,
    "cost" DECIMAL(10,2),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MealFood_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Inventory" (
    "id" TEXT NOT NULL,
    "userProfileId" TEXT NOT NULL,
    "foodId" TEXT NOT NULL,
    "quantity" DECIMAL(10,2) NOT NULL,
    "minimumQuantity" DECIMAL(10,2),
    "preferredQuantity" DECIMAL(10,2),
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Inventory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryLog" (
    "id" TEXT NOT NULL,
    "inventoryId" TEXT NOT NULL,
    "type" "InventoryLogType" NOT NULL,
    "quantity" DECIMAL(10,2) NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InventoryLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShoppingItem" (
    "id" TEXT NOT NULL,
    "userProfileId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "quantity" DECIMAL(10,2),
    "unit" "Unit",
    "status" "ShoppingItemStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShoppingItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Food_userProfileId_idx" ON "Food"("userProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "Food_userProfileId_name_key" ON "Food"("userProfileId", "name");

-- CreateIndex
CREATE INDEX "Meal_userProfileId_idx" ON "Meal"("userProfileId");

-- CreateIndex
CREATE INDEX "Meal_mealDate_idx" ON "Meal"("mealDate");

-- CreateIndex
CREATE INDEX "MealFood_mealId_idx" ON "MealFood"("mealId");

-- CreateIndex
CREATE INDEX "MealFood_foodId_idx" ON "MealFood"("foodId");

-- CreateIndex
CREATE UNIQUE INDEX "Inventory_foodId_key" ON "Inventory"("foodId");

-- CreateIndex
CREATE INDEX "Inventory_userProfileId_idx" ON "Inventory"("userProfileId");

-- CreateIndex
CREATE INDEX "InventoryLog_inventoryId_idx" ON "InventoryLog"("inventoryId");

-- CreateIndex
CREATE INDEX "ShoppingItem_userProfileId_idx" ON "ShoppingItem"("userProfileId");

-- AddForeignKey
ALTER TABLE "Food" ADD CONSTRAINT "Food_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES "UserProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Meal" ADD CONSTRAINT "Meal_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES "UserProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealFood" ADD CONSTRAINT "MealFood_mealId_fkey" FOREIGN KEY ("mealId") REFERENCES "Meal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealFood" ADD CONSTRAINT "MealFood_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inventory" ADD CONSTRAINT "Inventory_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES "UserProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inventory" ADD CONSTRAINT "Inventory_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryLog" ADD CONSTRAINT "InventoryLog_inventoryId_fkey" FOREIGN KEY ("inventoryId") REFERENCES "Inventory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShoppingItem" ADD CONSTRAINT "ShoppingItem_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES "UserProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;
