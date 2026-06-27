import { auth } from "@clerk/nextjs/server";

export default async function DashboardPage() {
  const { userId } = await auth();

  return (
    <main className="flex min-h-screen items-center justify-center">
      <div className="text-center">
        <h1 className="text-4xl font-bold">LifeOS Dashboard</h1>

        <p className="mt-6 text-lg">
          Signed in as:
        </p>

        <p className="font-mono mt-2">
          {userId}
        </p>
      </div>
    </main>
  );
}