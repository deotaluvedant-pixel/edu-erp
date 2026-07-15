/*
  Warnings:

  - You are about to drop the column `admissionDate` on the `Student` table. All the data in the column will be lost.
  - You are about to drop the column `classSectionId` on the `Student` table. All the data in the column will be lost.
  - You are about to drop the column `rollNumber` on the `Student` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `Student` table. All the data in the column will be lost.
  - Changed the type of `gender` on the `Student` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateEnum
CREATE TYPE "StudentEnrollmentStatus" AS ENUM ('ACTIVE', 'PROMOTED', 'PASSED', 'LEFT', 'CANCELLED');

-- DropForeignKey
ALTER TABLE "Student" DROP CONSTRAINT "Student_classSectionId_fkey";

-- AlterTable
ALTER TABLE "Student" DROP COLUMN "admissionDate",
DROP COLUMN "classSectionId",
DROP COLUMN "rollNumber",
DROP COLUMN "status",
DROP COLUMN "gender",
ADD COLUMN     "gender" "Gender" NOT NULL;

-- CreateTable
CREATE TABLE "StudentEnrollment" (
    "id" SERIAL NOT NULL,
    "studentId" INTEGER NOT NULL,
    "academicYearId" INTEGER NOT NULL,
    "classSectionId" INTEGER NOT NULL,
    "rollNumber" INTEGER NOT NULL,
    "admissionDate" TIMESTAMP(3) NOT NULL,
    "status" "StudentEnrollmentStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StudentEnrollment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "StudentEnrollment_academicYearId_classSectionId_rollNumber_key" ON "StudentEnrollment"("academicYearId", "classSectionId", "rollNumber");

-- AddForeignKey
ALTER TABLE "StudentEnrollment" ADD CONSTRAINT "StudentEnrollment_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentEnrollment" ADD CONSTRAINT "StudentEnrollment_academicYearId_fkey" FOREIGN KEY ("academicYearId") REFERENCES "AcademicYear"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentEnrollment" ADD CONSTRAINT "StudentEnrollment_classSectionId_fkey" FOREIGN KEY ("classSectionId") REFERENCES "ClassSection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
