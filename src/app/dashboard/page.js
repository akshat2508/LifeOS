import { auth } from "@clerk/nextjs/server";
import { redirect } from "next/navigation";

export default async function DashboardPage() {
  const { userId } = await auth();

  if (!userId) {
    redirect("/sign-in");
  }

  return (
    <main className="flex min-h-screen items-center justify-center">
      <div className="space-y-4 text-center">
        <h1 className="text-4xl font-bold">
          Welcome to LifeOS
        </h1>

        <p>{userId}</p>

        <form
          action="/api/users/sync"
          method="post"
        >
          <button
            className="rounded-lg bg-black px-5 py-3 text-white"
          >
            Sync User
          </button>
        </form>
      </div>
    </main>
  );
}