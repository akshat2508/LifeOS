import { syncCurrentUser } from "@/features/user/services/user.service";
import { success, failure } from "@/lib/api-response";

export async function POST() {
  try {
    const user = await syncCurrentUser();

    return success(user, "User synchronized");
  } catch (error) {
    console.error(error);

    return failure(error.message);
  }
}