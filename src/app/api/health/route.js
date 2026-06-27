import { success } from "@/lib/api-response";

export async function GET() {
  return success(
    {
      server: "LifeOS",
      version: "1.0.0",
    },
    "Backend is running"
  );
}