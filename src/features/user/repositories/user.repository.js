import { prisma } from "@/lib/prisma";

export async function findByClerkId(clerkId) {
  return prisma.userProfile.findUnique({
    where: {
      clerkId,
    },
  });
}

export async function createUser(data) {
  return prisma.userProfile.create({
    data,
  });
}