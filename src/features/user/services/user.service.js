import { currentUser } from "@clerk/nextjs/server";
import {
  findByClerkId,
  createUser,
} from "../repositories/user.repository";

export async function syncCurrentUser() {
  const clerkUser = await currentUser();

  if (!clerkUser) {
    throw new Error("Unauthorized");
  }

  const existing = await findByClerkId(clerkUser.id);

  if (existing) {
    return existing;
  }

  return createUser({
    clerkId: clerkUser.id,
    email: clerkUser.emailAddresses[0].emailAddress,
    fullName:
      `${clerkUser.firstName ?? ""} ${clerkUser.lastName ?? ""}`.trim(),
    imageUrl: clerkUser.imageUrl,
  });
}