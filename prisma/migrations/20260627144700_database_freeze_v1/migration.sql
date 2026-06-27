/*
  Warnings:

  - Added the required column `muscleGroup` to the `Exercise` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "MuscleGroup" AS ENUM ('CHEST', 'BACK', 'SHOULDERS', 'BICEPS', 'TRICEPS', 'FOREARMS', 'LEGS', 'CALVES', 'CORE', 'CARDIO', 'FULL_BODY', 'OTHER');

-- AlterTable
ALTER TABLE "Exercise" ADD COLUMN     "deletedAt" TIMESTAMP(3),
DROP COLUMN "muscleGroup",
ADD COLUMN     "muscleGroup" "MuscleGroup" NOT NULL;

-- AlterTable
ALTER TABLE "Food" ADD COLUMN     "deletedAt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Habit" ADD COLUMN     "deletedAt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "TransactionCategory" ADD COLUMN     "deletedAt" TIMESTAMP(3);

-- CreateIndex
CREATE INDEX "Exercise_userProfileId_idx" ON "Exercise"("userProfileId");
